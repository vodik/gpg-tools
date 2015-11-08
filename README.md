## gpg-exec

This useful bits of [envoy][] + `gpg-agent` distilled into a standalone
project, usable without running `envoyd`.

To use this, create a `systemd --user` service that looks like this:

    [Service]
    Type=forking
    ExecStart=/usr/bin/gpg-agent --daemon --enable-ssh-support

    [Install]
    WantedBy=multi-user.target

Then make sure you have the following in your environment (I use
`~/.pam_environment`):

    SSH_AUTH_SOCK=/home/simon/.gnupg/S.gpg-agent.ssh

Then you can use `gpg-exec` to the same effect as `envoy-exec`.

  [envoy]: https://github.com/vodik/envoy
