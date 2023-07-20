import typing

from kitty.boss import Boss
from kitty.cli import create_default_opts
from kitty.fast_data_types import get_options, viewport_for_window
from kitty.window import Window


def on_resize(
    boss: Boss, window: Window, data: typing.Mapping[str, typing.Any]
) -> None:
    """Kitty callback when the window is resized

    We switch the layout based on the total number of cells (symbols) we have
    horizontally, going from the vertical (default), tall (with one left-size
    full-sized window), and then tall (with 2 left-size full-sized window),
    when we have the maximum space available (e.g. full screen on a monitor).
    """

    # We first retrieve the default width for the window, which in my case
    # represents a single terminal session:
    default_width = get_options('initial_window_width')[0]

    # We add 1 cell to account for borders
    threshold = default_width + 1

    # We first estimate the width of the window.  It is not precise as the
    # window width include a couple of pixels to the left and right.  We
    # use the
    _, _, window_width, _, cell_width, _ = viewport_for_window(window.os_window_id)
    cells = window_width / cell_width
    if cells < (2 * threshold):
        boss.call_remote_control(window, ("goto-layout", "--match", "all", "vertical"))
    elif cells < (3 * threshold):
        boss.call_remote_control(
            window, ("goto-layout", "--match", "all", "tall:full_size=1")
        )
    elif cells < (4 * threshold):
        boss.call_remote_control(
            window, ("goto-layout", "--match", "all", "tall:full_size=2")
        )
    else:
        boss.call_remote_control(
            window, ("goto-layout", "--match", "all", "horizontal")
        )
