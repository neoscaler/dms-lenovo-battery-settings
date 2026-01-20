# dms-lenovo-battery-settings

Offers ability to see the status of Lenovo battery settings in DankBar and quickly change it:

* conservation mode (on, off)

In the future, changing the following settings is also planned:
* charging mode (long_life, standard)
* fast_charge (on, off)

> [!NOTE]
> Setting fast charging will require kernel 6.19+ 

## Dependencies

Works only for Lenovo ACPI devices with `/sys/bus/platform/devices/VPC2004:00` present.

Needs active polkit graphical authentication agent running for the toggle feature, for example polkit-gnome:

**~.config/niri/config.kdl**
```qml
spawn-at-startup "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1"
```

