#! /usr/bin/env python

"""Make a new python module."""

import sys
import os
import re
import argparse

def main(options):
    """Main program."""
    script_name = options.script_name

    module_name_re = re.compile(r'^[a-zA-Z][a-zA-Z0-9_]*\.pyw?$')
    if not module_name_re.match(os.path.basename(script_name)):
        script_name = script_name + '.py'
        warning_format = "Warning: appending .py - module file will be called %r.\n"
        sys.stderr.write(warning_format % script_name)

    if os.path.exists(script_name):
        error_format = "Error: the file %r already exists.\n"
        sys.stderr.write(error_format % script_name)
        sys.exit(2)

    
    description = '<++>' if options.placeholders else 'DESCRIPTION'
    with file(script_name, 'w') as script:
        script.write("#! /usr/bin/env python\n")
        script.write("\n")
        script.write('"""%s\n' % description)
        script.write('"""\n')
        script.write('\n')
        script.write('if __name__ == "__main__":\n')
        script.write('    import doctest\n')
        script.write('    doctest.testmod()\n')
    return

def get_options():
    """Get options for the script."""
    parser = argparse.ArgumentParser(
        description="generate a new python module"
    )
    parser.add_argument('script_name', help='name of script to create')
    parser.add_argument('-p', '--placeholders', action='store_true',
        default=False, help='insert <++> placeholders instead of comments'
    )
    options = parser.parse_args()
    return options

if __name__ == "__main__":
    main(get_options())


# vim: filetype=python
