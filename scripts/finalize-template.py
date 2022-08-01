import logging
import os
from argparse import ArgumentParser
from pathlib import Path
from typing import Any, Dict


def get_parser():
    parser = ArgumentParser(
        "Fills out argument templates, then destroys, saves the new files,"
        "and destroys all template files, including this script."
    )
    parser.add_argument('--app-name', required=True)
    parser.add_argument('--maintainer', required=True)
    parser.add_argument('--keepalive', required=False, default=False, action='store_true', dest='meta_keepalive')
    return parser


def get_template_files():
    return [
        str(path.joinpath()) for path in list(Path('.').rglob('*.template.*'))
    ]


def finalize_template_file(path: str, args: Dict[str, Any]):
    with open(path) as f:
        template = f.read()

    for key, val in args.items():
        template = template.replace(
            f'${{template:{key}}}', str(val)
        )

    new_file_name = path.replace('.template', '')
    with open(new_file_name, 'w') as f:
        f.write(template)

    logging.info(
        f"Generated {new_file_name} from {path}"
    )
    return new_file_name


def main():
    args = get_parser().parse_args()
    values = {
        k: v for k, v in vars(args).items()
        if not k.startswith('meta_')
    }
    logging.basicConfig(level=logging.INFO)
    logging.getLogger(__name__).setLevel(logging.INFO)
    templates = get_template_files()
    [finalize_template_file(t, values) for t in templates]
    if args.meta_keepalive:
        logging.info("Not deleting template files. You should re-run without the --keepalive flag to clean up!")
        return

    os.system('poetry update')

    for fn in templates:
        logging.info(f'Deleting template {fn}')
        os.remove(fn)
    logging.info('Deleting myself, too. My purpose is fulfilled. Byeeeeeeeeee!')
    os.remove(__file__)


if __name__ == "__main__":
    main()
