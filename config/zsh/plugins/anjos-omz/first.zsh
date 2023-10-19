if [ -x /usr/libexec/path_helper ]; then
  # Default path setup on macOS.
  # Updates values at /etc/paths and /etc/manpaths
  eval `/usr/libexec/path_helper`
fi

if [ -d "${HOME}/mamba/envs/shell" ]; then
  export PATH="${HOME}/mamba/envs/shell/bin:${PATH}"
fi

if [ -x "${HOME}/bin/nvim" ]; then
  export PATH="${HOME}/bin:${PATH}"
fi
