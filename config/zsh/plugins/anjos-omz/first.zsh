if [ -x /usr/libexec/path_helper ]; then
  # Default path setup on macOS.
  # Updates values at /etc/paths and /etc/manpaths
  eval `/usr/libexec/path_helper`
fi
