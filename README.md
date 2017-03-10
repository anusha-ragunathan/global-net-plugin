# global-net-plugin
A mock docker network plugin with global scope used only for testing purposes

- Use createPluginIpc.sh to create global-net-ipc-plugin, which can access the host ipc namespace. Uses Dockerfile.ipc to build the image and config.json.ipc to build the plugin.

- Use createPlugin.sh to create global-net-plugin, that's used in docker CI for testing network plugin filters. Uses Dockerfile.nested to build the image and config.json to build the plugin. Uses nested BUILD instruction that's not on master yet. (https://github.com/docker/docker/pull/31257)
