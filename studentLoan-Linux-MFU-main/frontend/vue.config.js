const { defineConfig } = require('@vue/cli-service')

module.exports = defineConfig({
  transpileDependencies: true,
  devServer: {
    host: process.env.VUE_APP_HOST || "0.0.0.0",
    port: process.env.VUE_APP_PORT || 1080,
    server: "https",
    allowedHosts: 'all',
  }
})
