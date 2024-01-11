export const healthControllerSwagger = {
  paths: {
    "/health": {
      get: {
        summary: "Check Health Status",
        description: "Check the health status of the server.",
        tags: ["Health"],
        responses: {
          200: {
            description: "The server is healthy.",
            content: {
              "text/plain": {
                schema: {
                  type: "string",
                  example: "Health: OK",
                },
              },
            },
          },
          500: {
            description: "Internal server error.",
            content: {
              "application/json": {
                schema: {
                  $ref: "#/components/schemas/ErrorResponse",
                },
              },
            },
          },
        },
      },
    },
  },
  components: {
    schemas: {
    }
  }
};
