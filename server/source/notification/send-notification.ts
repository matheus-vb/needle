import apn from "apn";
import { env } from "../env";
import { APNSingleton } from "./provider";

export function sendNotification(deviceToken: string, alert: string) {
    if(env.NODE_ENV === "DEV") {
        return
    }
    
    const provider = APNSingleton.shared().provider

    var notification = new apn.Notification();

    notification.topic = env.BUNDLE_ID
    notification.expiry = Math.floor(Date.now() / 1000) + 3600;
    notification.badge = 3;
    notification.sound = "default";
    notification.alert = alert;
    notification.payload = {'messageFrom': 'Needle App'};

    provider.send(notification, deviceToken).then((result) => {
        console.log(result.failed)
        console.log(result.sent)
    })
}