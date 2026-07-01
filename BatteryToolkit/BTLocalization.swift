//
// Copyright (C) 2022 Marvin Häuser. All rights reserved.
// SPDX-License-Identifier: BSD-3-Clause
//

import Foundation

internal enum BTLocalization {
    enum Prompts {
        static let ok = NSLocalizedString(
            "确定",
            comment: "Prompt button to acknowledge a situation"
        )

        static let approve = NSLocalizedString(
            "批准",
            comment: "Prompt button to approve an action"
        )

        static let cancel = NSLocalizedString(
            "取消",
            comment: "Prompt button to cancel an action"
        )

        static let retry = NSLocalizedString(
            "重试",
            comment: "Prompt button to retry an action"
        )

        static let quit = NSLocalizedString(
            "退出",
            comment: "Prompt button to quit the app"
        )

        static let disableAndQuit = NSLocalizedString(
            "禁用并退出",
            comment: "Prompt button to disable a core function and quit the app"
        )

        static let openSystemSettings = NSLocalizedString(
            "打开系统设置",
            comment: "Prompt button to open System Settings"
        )

        static let quitMessage = NSLocalizedString(
            "退出 Battery Toolkit？",
            comment: "Prompt caption asking whether to quit the app"
        )

        static let quitInfo = NSLocalizedString(
            "Battery Toolkit 将继续在后台运行。如需永久暂停，请从 Battery Toolkit 菜单中禁用后台活动。",
            comment: "Prompt caption asking whether to quit the app"
        )

        static let quitInfoMacOS13 = NSLocalizedString(
            "如需临时暂停，请在系统设置中禁用后台活动。",
            comment: "Prompt caption asking whether to quit the app"
        )

        static let unexpectedErrorMessage = NSLocalizedString(
            "发生意外错误。",
            comment: "Prompt caption informing the user of an unexpected error"
        )

        static let notAuthorizedMessage = NSLocalizedString(
            "您没有权限执行此操作。",
            comment: "Prompt caption informing the user that they are not authorized to perform a specific operation"
        )

        enum Daemon {
            static let requiredInfo = NSLocalizedString(
                "为了管理您 Mac 的电源状态，Battery Toolkit 需要在后台运行。",
                comment: "Prompt text explaining the requirement for background activity"
            )

            static let allowMessage = NSLocalizedString(
                "允许后台活动？",
                comment: "Prompt caption asking to allow background activity"
            )

            static let allowInfo = NSLocalizedString(
                "您想在系统设置中批准 Battery Toolkit 登录项吗？",
                comment: "Prompt text asking to approve background activity"
            )

            static let enableFailMessage = NSLocalizedString(
                "启用后台活动失败。",
                comment: "Prompt caption informing of failure to enable background activity"
            )

            static let disableMessage = NSLocalizedString(
                "禁用后台活动？",
                comment: "Prompt caption asking whether to disable background activity"
            )

            static let disableInfo = NSLocalizedString(
                "您想为 Battery Toolkit 禁用后台活动吗？",
                comment: "Prompt text asking whether to disable background activity"
            )

            static let disableFailMessage = NSLocalizedString(
                "禁用后台活动时发生错误。",
                comment: "Prompt caption informing of failure to disable background activity"
            )

            static let commFailMessage = NSLocalizedString(
                "无法与后台服务通信。",
                comment: "Prompt caption informing the user that the app failed to communicate with its background service"
            )

            static let commFailInfo = NSLocalizedString(
                "请重启 Mac 后重试。如果问题仍然存在，请联系开发者。",
                comment: "Prompt text instructing the user to restart the machine and try again"
            )

            static let unsupportedMessage = NSLocalizedString(
                "您的 Mac 不受支持。",
                comment: "Prompt caption informing the user that the app does not support this machine"
            )

            static let unsupportedInfo = NSLocalizedString(
                "Battery Toolkit 不支持管理您 Mac 的电源状态。后台活动将被禁用。",
                comment: "Prompt text informing the user the app does not support this machine and that background activity will be disabled in response"
            )
        }
    }

    static let preferences = NSLocalizedString(
        "偏好设置",
        comment: "Preferences for macOS 12 and below"
    )
}
