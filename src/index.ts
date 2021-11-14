import { config } from "dotenv";
import { resolve } from "path";
import { FurinkServer } from "./FurinkServer";

console.log(`
@furink/database v${require("../package.json").version}
Author: ${require("../package.json").author}
`);

// Load .env file if not in production.
if (process.env.NODE_ENV !== "production") {
	config();
}

const server = new FurinkServer({
	protocolDirectory: resolve(process.cwd(), process.env.PROTOCOL_DIRECTORY!),
});
server.loadProtocols();
