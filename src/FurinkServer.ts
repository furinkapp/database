import { PrismaClient } from "@prisma/client";
import { createLogger, transports, format } from "winston";

import { Server, ServerCredentials } from "@grpc/grpc-js";

interface ServerOptions {
	protocolDirectory: string;
	host: string;
	port: number;
}

export class FurinkServer {
	private readonly prisma = new PrismaClient();
	private readonly grpc = new Server();

	private readonly logger = createLogger({
		transports: [
			new transports.Console({
				format: format.combine(format.colorize(), format.simple()),
			}),
		],
	});

	constructor(readonly options: ServerOptions) {}

	/**
	 * Load protocols used by the gRPC server.
	 */
	async loadProtocols() {
		this.logger.info("Loading protocols...");
		this.logger.warn("TODO: Load the protocols!");
	}

	/**
	 * Create secure gRPC server credentials
	 */
	async createServerCredentials() {}

	/**
	 * Start the gRPC server on the specified port and host.
	 * @param host The host to listen on.
	 * @param port The port to listen on.
	 */
	async start(host = this.options.host, port = this.options.port.toString()) {
		this.logger.info(`Listening on ${host}:${port}`);
		this.grpc.bindAsync(
			`${host}:${port}`,
			ServerCredentials.createInsecure(),
			() => this.grpc.start()
		);
	}
}
