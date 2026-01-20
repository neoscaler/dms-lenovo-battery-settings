import QtQuick
import qs.Common
import qs.Modules.Plugins
import qs.Widgets

PluginSettings {
    id: root
    pluginId: "dmsLenovoBatterySettings"

    StyledText {
        width: parent.width
        text: "Lenovo battery settings config"
        font.pixelSize: Theme.fontSizeLarge
        font.weight: Font.Bold
        color: Theme.surfaceText
    }

    StyledText {
        width: parent.width
        text: "Click the icon in your bar to toggle specific battery setting"
        font.pixelSize: Theme.fontSizeSmall
        color: Theme.surfaceVariantText
        wrapMode: Text.WordWrap
    }

    SliderSetting {
        settingKey: "refreshInterval"
        label: "Refresh Interval"
        description: "Context refresh interval (in seconds)."
        defaultValue: 5
        minimum: 1
        maximum: 600
        unit: "sec"
        leftIcon: "schedule"
    }
}
