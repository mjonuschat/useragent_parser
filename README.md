# UseragentParser

UseragentParser is a library to detect useful information contained
within the Useragent Header transmitted by modern web clients.

# Usage

    require 'useragent_parser'
    ua = UseragentParser.parse('Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_6_4; en-US) AppleWebKit/525.13 (KHTML, like Gecko) Chrome/8.0.552.237 Safari/525.13')

This will return a hash containing the following keys:

  **family** - The browser family
  **v1**     - The major browser version
  **v2**     - The minor browser version
  **v3**     - The patch level of the browser
  **os_family**   - The operating system
  **os_v1**       - The major operating system version
  **os_v2**       - The minor operating system version
  **os_v3**       - The patch level of the operating system

In the case that the **family** or **os_family** is unknown, 'Other' will be
returned. The version components will return _nil_ in the case that the
respective version level in undetectable.

# Additional information

This is a port of the Python [ua-parser](http://code.google.com/p/ua-parser/) library.

## Maintainers

 * Morton Jonuschat ([github.com/yabawock](https://github.com/yabawock))

# License

Copyright 2011 Morton Jonuschat

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

   http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

