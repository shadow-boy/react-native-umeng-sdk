
var { NativeModules } = require('react-native');
const UMPushModule = NativeModules.UMPushModule;


export default class UPushModule {
    static addTag = (tag: string, callback: (code: number, ret: number) => void) => {
        UMPushModule.addTag(tag, callback);
    }

    static deleteTag = (tag: string, callback: (code: number, ret: number) => void) => {
        UMPushModule.deleteTag(tag, callback);
    }

    static listTag = (callback: (code: number, data: Array<string>) => void) => {
        UMPushModule.listTag(callback);
    }

    static addAlias = (alias: string, aliasType: string, callback: (code: number) => void) => {
        UMPushModule.addAlias(alias, aliasType, callback);
    }

    /**
     * android端暂未实现
     * @param eventId
     * @param map
     */
    static addAliasType = (eventId: string, map: { [key: string]: string }) => {
        console.log(`eventId--->${eventId},map---->${map}`);

    }

    static addExclusiveAlias = (exclusiveAlias: string, aliasType: string, callback: (code: number) => void) => {
        UMPushModule.addExclusiveAlias(exclusiveAlias, aliasType, callback);
    }

    static deleteAlias = (alias: string, aliasType: string, callback: (code: number) => void) => {
        UMPushModule.deleteAlias(alias, aliasType, callback);
    }

    static appInfo = (callback: (info: string) => void) => {
        UMPushModule.appInfo(callback);
    }
}
