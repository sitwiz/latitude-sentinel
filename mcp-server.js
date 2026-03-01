const { Server } = require("@modelcontextprotocol/sdk/server/index.js");
const { StdioServerTransport } = require("@modelcontextprotocol/sdk/server/stdio.js");

const server = new Server({
  name: "sentinel-os-mcp",
  version: "1.0.0",
}, {
  capabilities: { resources: {}, tools: {} }
});

// This tool allows an AI to ask for your node's health
server.setRequestHandler("listTools", async () => ({
  tools: [{
    name: "get_node_status",
    description: "Get real-time health and sync status of the Reth/Lighthouse node",
    inputSchema: { type: "object", properties: {} }
  }]
}));

async function main() {
  const transport = new StdioServerTransport();
  await server.connect(transport);
}

main().catch(console.error);
