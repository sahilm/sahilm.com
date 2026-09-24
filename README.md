Source code and articles for [Sahil Muthoo’s website](https://sahilm.github.io/sahilm.com/)

## Build and preview

Install the Ruby version in `.ruby-version` and Node.js (used for JavaScript
minification), then run:

```sh
bundle install
bundle exec middleman server
```

To build the production site into `build/`:

```sh
bundle exec rake build:production
```

## GitHub Pages

`.github/workflows/pages.yml` builds pull requests and publishes pushes to
`master`. It can also be run manually from the Actions tab. Deployment uses
GitHub's built-in token; no AWS credentials or separate deployment token is needed.

The site is hosted at https://sahilm.github.io/sahilm.com/ with HTTPS enforced.
In repository **Settings → Pages**, select **GitHub Actions** as the source and
leave the custom domain empty.

Production builds use `/sahilm.com` as Middleman's `http_prefix`. Navigation,
assets, canonical URLs, feeds, and the sitemap use this prefix. The development
server uses `/` for local preview.

To move to a custom domain later, update `site_origin` and the production
`http_prefix` in `config.rb`, configure the custom domain in Pages settings,
and then update DNS. No repository `CNAME` file is needed for Actions publishing.

# LICENSES

All written content such as articles are licensed under [CC BY-NC-SA 4.0](https://creativecommons.org/licenses/by-nc-sa/4.0/).

All source code is licensed under the MIT license.

The MIT License (MIT)

Copyright (c) 2017 Sahil Muthoo

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
