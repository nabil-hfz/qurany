// import { KhatmaController } from "../controllers/khatma-controller/khatma-controller.ts";


// KhatmaController
const swaggerDefinition = {
    // Like the one described here: https://swagger.io/specification/#infoObject
    basePath: '/',
    openapi: '3.0.0',
    info: {
        title: 'Express API for Kawtharuna',
        version: '1.0.0',
        description: 'This is a REST API application made with Express.',
    },
    servers: [
        {
            url: 'http://localhost:3000',
            description: 'Development server',
        }
        // ,
        // {
        //     url: 'https://www.api.kawtharuna.com/v1',
        //     description: 'Production server',
        // },
    ],
};


export const options = {
    swaggerDefinition,
    apis: [
        "src/controllers/khatma-controller/*.ts",
        "src/controllers/khatma-controller/responses/*.ts"
    ],
};

// npm install swagger-ui-express swagger-jsdoc --save
