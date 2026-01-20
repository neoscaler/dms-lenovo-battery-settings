# dms-lenovo-battery-settings

Plugin to see the status of following Lenovo battery settings in [DankBar](https://github.com/AvengeMedia/DankMaterialShell) and quickly change it:

* conservation mode (on, off)
    * Charges only to 60-80 % to preserve battery health

In the future, changing the following settings is also planned:
* charging mode (long_life, standard)
* fast_charge (on, off)

> [!NOTE]
> Setting fast charging will require kernel 6.19+ 

## Dependencies

Works only for Lenovo ACPI devices with `/sys/bus/platform/devices/VPC2004:00` present.

Needs polkit graphical authentication agent running for the toggle feature, for example polkit-gnome:

**~.config/niri/config.kdl**
```qml
spawn-at-startup "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1"
```
