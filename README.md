## Standard - Ruby style guide, linter, and formatter

[![CircleCI](https://circleci.com/gh/testdouble/standard.svg?style=svg)](https://circleci.com/gh/testdouble/standard)

This gem is a spiritual port of [StandardJS](https://standardjs.com) and aims
to save you (and others!) time in the same three ways:

* **No configuration.** The easiest way to enforce consistent style in your
  project. Just drop it in.
* **Automatically format code.** Just run `standard --fix` and say goodbye to
  messy or inconsistent code.
* **Catch style issues & programmer errors early.** Save precious code review
  time by eliminating back-and-forth between reviewer & contributor.

No decisions to make. It just works.

Install by adding it to your Gemfile:

```ruby
gem "standard", :group => [:development, :test]
```

And running `bundle install`.

Run Standard from the command line with:

```ruby
$ bundle exec standard
```

And if you'd like, Standard can autocorrect your code by tacking on a `--fix`
flag.

## StandardRB — The Rules

- **2 spaces** – for indentation
- **Double quotes for string literals** - because pre-committing to whether
  you'll need interpolation in a string slows people down
- **1.9 hash syntax** - When all the keys in a hash literal are symbols,
  Standard enforces Ruby 1.9's `{hash: syntax}`
- **Semantic blocks** - `{`/`}` for functional blocks that return a value, and
  `do`/`end` for procedural blocks that have side effects. More
  [here](http://www.virtuouscode.com/2011/07/26/the-procedurefunction-block-convention-in-ruby/)
  and [here](https://github.com/rubocop-hq/ruby-style-guide/issues/162)
- **Trailing dots on multi-line method chains** - chosen because it makes
  copying lines into a REPL easier
- **And a good deal more**

If you're familiar with [RuboCop](https://github.com/rubocop-hq/rubocop), you
can look at Standard's current base configuration in
[config/base.yml](/config/base.yml).

**[NOTE: until StandardRB hits 1.0.0, we consider this configuration to be a
non-final work in progress and we encourage you to submit your opinions (and
reasoned arguments) for the addition, removal, or change to a rule by [opening
an issue](https://github.com/testdouble/standard/issues/new). If you start using
Standard, don't be shocked if things change a bit!]**

## Usage

Once you've installed `standard`, you should be able to use the `standard`
program. The simplest use case would be checking the style of all Ruby
files in the current working directory:

```bash
$ bundle exec standard
standard: Use Ruby Standard Style (https://github.com/testdouble/standard)
standard: Run `standard --fix` to automatically fix some problems.
  /Users/code/cli.rb:31:23: Style/Semicolon: Do not use semicolons to terminate expressions.
```

You can optionally pass in a directory (or directories) using the glob pattern. Be
sure to quote paths containing glob patterns so that they are expanded by
`standard` instead of your shell:

```bash
$ bundle exec standard "lib/**/*.rb" test
```

**Note:** by default `standard` will look for all `*.rb` files (and some other
files typically associated with Ruby like `*.gemspec` and `Gemfile`)

### Using with Rake

Standard also ships with Rake tasks. If you're using Rails, these should
autoload and be available after installing Standard. Otherwise, just require the
tasks in your `Rakefile`:

```ruby
require "standard/rake"
```

Here are the tasks bundled with Standard:

```
$ rake standard     # equivalent to running `standard`
$ rake standard:fix # equivalent to running `standard --fix`
```

You may also pass command line options to Standard's Rake tasks by embedding
them in a `STANDARDOPTS` environment variable (similar to how the Minitest Rake
task accepts CLI options in `TESTOPTS`).

```
# equivalent to `standard --format progress`:
$ rake standard STANDARDOPTS="--format progress"

# equivalent to `standard lib "app/**/*"`, to lint just certain paths:
$ rake standard STANDARDOPTS="lib \"app/**/*\""
```

## Using with AtomLinter

Standard is compatible with [AtomLinter](https://atomlinter.github.io/)'s
[linter-rubocop](https://github.com/AtomLinter/linter-rubocop) package. To use
Standard with linter-rubocop, you need to do two things:

1. Configure linter-rubocop to run `standard` as its **Command**.
2. Add the flags `--silence-cta --no-display-cop-names` to the end of the
   **Command**. The first flag will suppress Standard's pre-1.0 CTA message when
   warnings are detected. The second will prevent RuboCop from showing cop names
   in offense messages.

Now you can see Standard's warnings in Atom.

## What you might do if you're clever

If you want or need to configure Standard, there are a _handful_ of options
are available creating a `.standard.yml` file in the root of your project.

Here's an example yaml file with every option set:

```yaml
fix: true
parallel: true
format: progress
ruby_version: 2.3.3

ignore:
  - 'db/schema.rb'
  - 'vendor/bundle/**/*'
  - 'test/**/*':
    - Layout/AlignHash
```

## What you might do if you're REALLY clever

Because StandardRB is essentially a wrapper on top of
[RuboCop](https://github.com/rubocop-hq/rubocop), it will actually forward the
vast majority of CLI and ENV arguments forward to RuboCop.

You can see a list of
[RuboCop](https://docs.rubocop.org/en/latest/basic_usage/#other-useful-command-line-flags)'s
CLI flags here.

## Why should I use Ruby Standard Style?

(This section will [look
familiar](https://github.com/standard/standard#why-should-i-use-javascript-standard-style)
if you've used StandardJS.)

The beauty of Ruby Standard Style is that it's simple. No one wants to
maintain multiple hundred-line style configuration files for every module/project
they work on. Enough of this madness!

This gem saves you (and others!) time in three ways:

- **No configuration.** The easiest way to enforce consistent style in your
  project. Just drop it in.
- **Automatically format code.** Just run `standard --fix` and say goodbye to
  messy or inconsistent code.
- **Catch style issues & programmer errors early.** Save precious code review
  time by eliminating back-and-forth between reviewer & contributor.

Adopting `standard` style means ranking the importance of code clarity and
community conventions higher than personal style. This might not make sense for
100% of projects and development cultures, however open source can be a hostile
place for newbies. Setting up clear, automated contributor expectations makes a
project healthier.

## Who uses Ruby Standard Style?

(This section will not [look very
familiar](https://github.com/standard/standard#who-uses-javascript-standard-style)
if you've used StandardJS.)

* [Test Double](https://testdouble.com/agency)
* And that's about it so far!

## What if I also have StandardJS installed?

**[Note: While StandardRB is pre-1.0.0, we are waiting for user feedback before
deciding whether to mitigate this issue through cleverness or eliminate it by
changing the bin name. Please comment on [this
issue](https://github.com/testdouble/standard/issues/3) if you run into a
real-world problem trying to run either type of Standard.]**

Because StandardRB and StandardJS (and perhaps future packages for other
languages) both ship with binaries named `standard`, having both installed
globally and then executing them from your PATH will—at the moment—run whichever
one is found earlier in the PATH.

Ambiguity is bad, but we're banking on the majority of JS users to run standard
from a [package script](https://docs.npmjs.com/misc/scripts) and the majority of
Ruby developers to run standard from a [Bundler
binstub](https://bundler.io/v1.10/bundle_binstubs.html) or [Rake
task](#using-with-rake).

For every other case, if you're using both standard programs, note that
StandardRB ships with a `standardrb` bin, and we have a [pull request
open](https://github.com/standard/standard/pull/1224) to StandardJS to add a
`standardjs` alias so that either program can be run without any ambiguity.

## Is there a readme badge?

Yes! If you use `standard` in your project, you can include one of these badges
in your readme to let people know that your code is using the standard style.


[![Ruby Style Guide](https://img.shields.io/badge/code_style-standard-brightgreen.svg)](https://github.com/testdouble/standard)

```md
[![Ruby Style Guide](https://img.shields.io/badge/code_style-standard-brightgreen.svg)](https://github.com/testdouble/standard)
```

## I disagree with rule X, can you change it?

**[NOTE: until StandardRB hits 1.0.0, the answer is yes! It just requires
[opening an issue](https://github.com/testdouble/standard/issues/new) and
convincing [@searls](https://twitter.com/searls) (the BDFNow) to make the
change.]**

No. The whole point of `standard` is to save you time by avoiding
[bikeshedding](https://www.freebsd.org/doc/en/books/faq/misc.html#bikeshed-painting)
about code style. There are lots of debates online about tabs vs. spaces, etc.
that will never be resolved. These debates just distract from getting stuff
done. At the end of the day you have to 'just pick something', and that's the
whole philosophy of `standard` -- its a bunch of sensible 'just pick something'
opinions. Hopefully, users see the value in that over defending their own
opinions.

Pro tip: Just use `standard` and move on. There are actual real problems that
you could spend your time solving! :P

## Is there an automatic formatter?

Yes! You can use `standard --fix` to fix most issues automatically.

`standard --fix` is built into `standard` for maximum convenience. Most problems
are fixable, but some errors (like forgetting to handle errors) must be fixed
manually.

To save you time, `standard` outputs the message "`Run standard --fix to
automatically fix some problems`" when it detects problems that can be fixed
automatically.

## How do I ignore files?

Sometimes you need to ignore additional folders or specific minified files. To
do that, add a `.standard.yml` file to the root of your project and specify a
list of files and globs that should be excluded:

```yaml
ignore:
  - 'db/schema.rb'
  - 'vendor/bundle/**/*'
```

## How do I hide a certain warning?

In rare cases, you'll need to break a rule and hide the warning generated by
`standard`.

Ruby Standard Style uses [RuboCop](https://github.com/rubocop-hq/rubocop)
under-the-hood and you can hide warnings as you normally would if you used
RuboCop directly.

To ignore only certain rules from certain globs (not recommended, but maybe your
test suite uses a non-standardable DSL, you can specify an array of RuboCop
rules to ignore for a particular glob:

```yaml
ignore:
  - 'test/**/*':
    - Style/BlockDelimiters
```

You can also use special comments to disable all or certain rules within your
source code. See [RuboCop's
docs](https://docs.rubocop.org/en/latest/configuration/#disabling-cops-within-source-code)
for details.

## How do I specify a Ruby version? What is supported?

Because Standard wraps RuboCop, they share the same [runtime
requirements](https://github.com/rubocop-hq/rubocop#compatibility)—currently,
that's MRI 2.2 and newer. While Standard can't avoid this runtime requirement,
it does allow you to lint codebases that target Ruby versions older than 2.2 by
narrowing the ruleset somewhat.

Standard will default to telling RuboCop to target the currently running version
of Ruby (by inspecting `RUBY_VERSION` at runtime. But if you want to lock it
down, you can specify `ruby_version` in `.standard.yml`.

```
ruby_version: 1.8.7
```

See
[testdouble/suture](https://github.com/testdouble/suture/blob/master/.standard.yml)
for an example.

It's a little confusing to consider, but the targeted Ruby version for linting
may or may not match the version of the runtime (suppose you're on Ruby 2.5.1,
but your library supports Ruby 2.2.0). In this case, specify `ruby_version` and
you should be okay. However, note that if you target a _newer_ Ruby version than
the runtime, RuboCop may behave in surprising or inconsistent ways.

If you are targeting a Ruby older than 2.2 and run into an issue, check out
Standard's [version-specific RuboCop
configurations](https://github.com/testdouble/standard/tree/master/config) and
consider helping out by submitting a pull request if you find a rule that won't
work for older Rubies.

## How do I change the output?

Standard's built-in formatter is intentionally minimal, printing only unfixed
failures or (when successful) printing nothing at all. If you'd like to use a
different formatter, you can specify any of RuboCop's built-in formatters or
write your own.

For example, if you'd like to see colorful progress dots, you can either run
standard with:

```
$ bundle exec standard --format progress
Inspecting 15 files
...............

15 files inspected, no offenses detected
```

Or, in your project's `.standard.yml` file, specify:

```yaml
format: progress
```

Refer to RuboCop's [documentation on
formatters](https://rubocop.readthedocs.io/en/latest/formatters/) for more
information.
