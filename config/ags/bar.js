const Hypr = await Service.import("hyprland")
const Net = await Service.import("network")

const Date = Variable("NaN", {
    poll: [60_000, `date +"(%a) %d.%m.%y %H:%M"`]
})

const Module = (children, class_name, hpack) => Widget.Box({
    children, hpack, class_name: "module " + class_name, spacing: 8
})

function Left(monitor = 0) {
    const icons = {
        nixos: "\u{F313}"
    }

    const modules = {
        flex_nixos: () => Widget.Label({ label: icons.nixos }),
        active_window: active => Widget.Label({
            label: active.client.title.slice(0, 50).trim() +
                (active.client.title.length > 50 ? "..." : ""),
        })
    }

    return Module(
        Utils.merge([Hypr.bind("active")], (active) => [Widget.Box({
            spacing: 12,
            children: [
                modules.flex_nixos(),
                modules.active_window(active)
            ]})]), "left", "start", {}
    )
}

function Center(monitor = 0) {
    const set_workspace = w => Hypr.messageAsync(`dispatch workspace ${w}`)
    
    const icons = {
        active_workspace: "\u{F111}",
        inactive_workspace: "\u{F111}"
    }

    const modules = {
        workspaces: (ws, active) => Widget.Box({ children: ws
            .filter(w => w.monitorID == monitor)
            .sort((a, b) => a.id - b.id)
            .map(w => Widget.Button({
                // label: w.id == active.workspace.id ? icons.active_workspace : icons.inactive_workspace,
                label: w.name,
                class_name: (w.id == active.workspace.id ? "active" : "inactive") + " text-button",
                on_clicked: () => set_workspace(w.id)
            })),
        }),
    }
    
    return Module(
        Utils.merge([Hypr.bind("active"), Hypr.bind("workspaces")], (active, ws) => [
            modules.workspaces(ws, active)
        ]),
        "center", "center", {}
    )
}

function Right(monitor = 0) {
    const icons = {
        wifi_strength: ["\u{F092F}", "\u{F091F}", "\u{F0922}", "\u{F0925}", "\u{F0928}"],
        no_wifi: "\u{F092D}"
    }

    const modules = {
        wifi: wifi => Widget.Label({ label: wifi.enabled ? icons.wifi_strength[Math.floor(wifi.strength / 20) - 1] : icons.no_wifi }),
        date: date => Widget.Label({ label: date })
    }
 
    return Module(
        Utils.merge([Net.bind("wifi"), Date.bind()], (wifi, date) => [
            modules.date(date),
            modules.wifi(wifi)
        ]),
        "right", "end", {}
    )
}

export function Bar(monitor = 0) {
    return Widget.Window({
        name: `bar-${monitor}`,
        anchor: ["top", "left", "right"],
        class_name: "bar",
        child: Widget.CenterBox({
            spacing: 0,
            class_name: "in-bar",
            start_widget: Left(monitor),
            center_widget: Center(monitor),
            end_widget: Right(monitor)
        }),
        exclusivity: "exclusive",
        monitor
    })
}
