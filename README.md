# Codeforces::Viewer

A simple command-line viewer for Codeforces.

[![Gem Version](https://badge.fury.io/rb/codeforces-viewer.png)](http://badge.fury.io/rb/codeforces-viewer)
[![Build Status](https://travis-ci.org/sh19910711/ruby-codeforces-viewer.png?branch=develop)](https://travis-ci.org/sh19910711/ruby-codeforces-viewer)

## Installation

    $ gem install codeforces-viewer

## Usage

### How to view problem statement

    $ codeforces-viewer -c {contest-id} -p {problem-id}

#### Example usage

    $ codeforces-viewer -c 123 -p A

#### One More Thing: Use pager command [less, more, etc...]

    $ codeforces-viewer -c 123 -p A | less -R

### Download sample input/output

#### Download sample input

    $ codeforces-viewer -c 123 -p A -i 0 > input.all.txt

You can specify input id as follow:

    $ codeforces-viewer -c 123 -p A -i 1 > input.1.txt

#### Donwload sample output

    $ codeforces-viewer -c 123 -p A -o 0 > input.all.txt

You can also specify output id as follow:

    $ codeforces-viewer -c 123 -p A -o 2 > output.2.txt

#### Disable to cache

Downloaded files (currently, html files only) are cached (in `~/.codeforces-viewer/cache/*`) by default.

When you don't want to cache them, add `--no-cache` option as follow:

    $ codeforces-viewer -c 123 -p A --no-cache | less -R

## Contributing

1. Fork it ( https://github.com/sh19910711/ruby-codeforces-viewer/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

Copyright (c) 2014 [Hiroyuki Sano](https://github.com/sh19910711)

MIT License

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.



