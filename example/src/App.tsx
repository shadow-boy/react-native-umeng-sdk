import type { UMWeb } from 'lib/typescript/types'
import React, { Component } from 'react'
import { Button, StyleSheet, Text, View } from 'react-native'
import { ShareMedias, ShareStyles, UShareModule } from 'react-native-umeng-sdk'

const shareLogoURL = "https://lc-gluttony.s3.amazonaws.com/BivEqB72Y97E/1604DxAUGi4CSWXEYYhR7AxmP0whPPbV/share_logo.png"

export default class App_Share extends Component {

  render() {
    return (
      <View style={[StyleSheet.absoluteFill, { justifyContent: 'center', alignItems: 'center' }]}>
        <Button
          title="微信share"
          onPress={async () => {

            let shareObject: UMWeb = {
              title: "this is title",
              description: "this is description",
              thumb: shareLogoURL,
              url: "https://www.baidu.com",
              shareMedias: [ShareMedias.WEIXIN]
            }
            try {
              let result = await UShareModule.share(ShareStyles.LINK, shareObject)

            } catch (error) {
              debugger
            }
          }}></Button>

      </View>
    )
  }
}
