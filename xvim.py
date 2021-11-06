#!/Users/andre/mamba/envs/neovim/bin/python3

"""Starts neovim in a new iterm2 window, honours all arguments

Requires the environment to have "pyobjc" and "iterm2"
"""

import os
import sys
import AppKit
import iterm2


async def window_main(connection):
    """Runs a command on the current connection"""

    app = await iterm2.async_get_app(connection)

    # Foreground the app
    await app.async_activate()

    cmd = [
        "/usr/bin/env",
        f"PATH='{os.environ['PATH']}'",
        "nvim",
    ]
    cmd += [f'"{k}"' for k in sys.argv[1:]]
    # print(" ".join(cmd))

    # defines command to run and working directory
    profile = iterm2.LocalWriteOnlyProfile()
    profile.set_command(" ".join(cmd))
    profile.set_initial_directory_mode(
        iterm2.InitialWorkingDirectory.INITIAL_WORKING_DIRECTORY_CUSTOM
    )
    profile.set_custom_directory(os.path.realpath(os.curdir))

    # This will run 'nvim' from bash. If you use a different shell, you will
    # need to change it here.  Running it through the shell sets up your $PATH
    # so you do not need to specify a full path to the command.
    await iterm2.Window.async_create(
        connection,
        profile="Neovim",
        profile_customizations=profile,
    )


def main():

    # Launches the app
    AppKit.NSWorkspace.sharedWorkspace().launchApplication_("iTerm2")

    # Passing True for the second parameter means keep trying to
    # connect until the app launches.
    iterm2.run_until_complete(window_main, True)


if __name__ == "__main__":
    main()
