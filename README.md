# My [Kanata](https://github.com/jtroo/kanata) Configs

Config options [here](https://jtroo.github.io/config.html).

## Setup

### Linux

I'd start by just getting kanata running manually, to make sure everything is working. To do so, run `setup-linux.sh` or follow the instructions [here](https://github.com/jtroo/kanata/blob/main/docs/setup-linux.md), up to step 5.

If successful, you should be able to run:

```bash
kanata -c linux.kbd
```

To generate the systemd service, execute `generate_systemd_service.sh`

Then you can start it as described at the same link above:

```bash
systemctl --user daemon-reload
systemctl --user enable kanata.service
systemctl --user start kanata.service
systemctl --user status kanata.service
```

### MacOS
