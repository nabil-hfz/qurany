const pm2Name = process.env.NODE_ENV == 'prod' ?
    'kawtharuna-server' : 'kawtharuna-server-dev';
console.log('pm2Name:', pm2Name);

module.exports = {
    apps: [
        {
            name: pm2Name,
            script: './dist/src/index.js',
        },
    ],
};