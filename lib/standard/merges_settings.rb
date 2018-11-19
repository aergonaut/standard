require "rubocop"

module Standard
  class MergesSettings
    Settings = Struct.new(:options, :paths)

    def call(argv, standard_yaml)
      standard_argv, rubocop_argv = separate_argv(argv)
      standard_cli_flags = parse_standard_argv(standard_argv)
      rubocop_cli_flags, lint_paths = RuboCop::Options.new.parse(rubocop_argv)

      Settings.new(
        merge(standard_yaml, standard_cli_flags, rubocop_cli_flags),
        lint_paths
      )
    end

    private

    def separate_argv(argv)
      argv.partition { |flag| %w[--fix --silence-cta --version -v].include?(flag) }
    end

    def parse_standard_argv(argv)
      argv.each_with_object({}) { |arg, cli_flags|
        case arg
        when "--version", "-v"
          cli_flags[:version] = true
        when "--fix"
          cli_flags[:auto_correct] = true
          cli_flags[:safe_auto_correct] = true
        when "--silence-cta"
          cli_flags[:silence_cta] = true
        end
      }
    end

    def merge(standard_yaml, standard_cli_flags, rubocop_cli_flags)
      {
        auto_correct: standard_yaml[:fix],
        safe_auto_correct: standard_yaml[:fix],
        formatters: [[standard_yaml[:format] || "Standard::Formatter", nil]],
        parallel: standard_yaml[:parallel],
      }.merge(standard_cli_flags).merge(rubocop_cli_flags)
    end
  end
end
