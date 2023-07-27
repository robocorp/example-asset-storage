import json
from pathlib import Path

from robocorp import storage
from robocorp.tasks import task


NAME = "robocorp-awesome"
TEXT = "Robocorp is awesome"


def store_json(text: str) -> str:
    """Setting a JSON dictionary in a new asset."""
    json_name = f"{NAME}-json"
    storage.set_json(json_name, {"text": text})
    return json_name


def store_file(json_name: str) -> str:
    """Setting a file asset with the previously set JSON content."""
    value = storage.get_json(json_name)
    path = Path("output") / f"{NAME}.json"
    with open(path, "w") as stream:
        json.dump(value, stream)
    file_name = f"{NAME}-file"
    storage.set_file(file_name, path)
    path = storage.get_file(file_name, path, exist_ok=True)
    return path


@task
def manage_assets():
    # Ensure initial simple text asset.
    storage.set_text(NAME, TEXT)

    text = storage.get_text(NAME)
    json_name = store_json(text)
    path = store_file(json_name)
    print("Retrieved file asset:", path)

    # Assets cleanup.
    for asset in storage.list_assets():
        if asset.startswith("robocorp"):
            print("Removing asset:", asset)
            storage.delete_asset(asset)
