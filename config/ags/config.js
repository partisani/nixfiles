import { Bar } from "./bar.js"

App.config({
    windows: [
        Bar(0),
        // Bar(1),
        // Bar(2)
    ],
    style: "./style.css"
})

Utils.monitorFile(
    `${App.configDir}/style.css`,

    () => { App.resetCss(); App.applyCss(`${App.configDir}/style.css`) }
)
