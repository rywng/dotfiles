import argparse
import collections
import json
import pathlib


class Profile:
    def __init__(self, object, json, groups_key="setting-groups"):
        self.json = json
        self.groups_key = groups_key

        self._settings = []
        self._shaders = []

        self._collect(object)

    def _collect(self, object):
        self._settings.extend(object.get("settings", []))
        self._shaders.extend(object.get("shaders", []))

        for key in object.get(self.groups_key, []):
            self._collect(self.json["setting-groups"][key])


parser = argparse.ArgumentParser()

parser.add_argument("--profile", default=None)
parser.add_argument(
    "--path", default=f"{pathlib.Path.home()}/.config/mpv/default-shader-pack")
parser.add_argument("--config", default=False, action="store_true")

arguments = parser.parse_args()
arguments.path = str(pathlib.Path(arguments.path))


# with open(pathlib.Path(arguments.path, "pack.json"), "rb") as file:
with open(pathlib.Path(arguments.path, "pack-hq.json"), "rb") as file:
    json_ = json.load(file)


if arguments.profile is None:
    for profile in json_["profiles"].values():
        print(profile["displayname"])

else:
    if arguments.config:
        prefix = ""
        end = None

    else:
        prefix = "--"
        end = " "

    default_profile = Profile(
        json_, json_, groups_key="default-setting-groups")

    (_,) = (
        profile
        for profile in json_["profiles"].values()
        if profile["displayname"] == arguments.profile
    )
    profile = Profile(_, json_)
    for key, value in collections.OrderedDict(
        default_profile._settings + profile._settings
    ).items():
        key = key.replace("_", "-")

        if value is True:
            print(prefix, key, sep="", end=end)
            continue

        print(prefix, key, "=", value, sep="", end=end)

    print(
        prefix,
        "glsl-shaders=",
        ":".join(
            str(pathlib.Path(arguments.path, "shaders", shader))
            for shader in collections.OrderedDict(
                (_, None) for _ in default_profile._shaders + profile._shaders
            ).keys()
        ),
        sep="",
        end=end,
    )

    print()
