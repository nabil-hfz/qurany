"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.instantiateCacheInterceptor = void 0;
const random_1 = require("../utils/random");
const logger_1 = require("../utils/logger");
const noDataFlag = 'no_data_internal_flag_' + (0, random_1.randomString)(10);
exports.instantiateCacheInterceptor = ((req, res, next) => {
    const _reqCacheKey = '_internal_cache_of_functions';
    req[_reqCacheKey] = {};
    req.cacheOf = (cacheId, generateCacheIfIsNeeded) => {
        /** Modified from https://stackoverflow.com/a/60666008/4508758 */
        const wrapper = (...args) => {
            var _a;
            if (!req[_reqCacheKey][cacheId]) {
                if (generateCacheIfIsNeeded == null) {
                    throw Error("There's no cache for cacheId '" + cacheId + "' and 'generateCacheIfIsNeeded' is null");
                }
                req[_reqCacheKey][cacheId] = (_a = (generateCacheIfIsNeeded(...args))) !== null && _a !== void 0 ? _a : noDataFlag;
                (0, logger_1.logDebug)('Obtained a new cache');
            }
            else {
                (0, logger_1.logDebug)('Didn\'t obtained a new cache');
            }
            const res = req[_reqCacheKey][cacheId];
            if (res == noDataFlag) {
                return Promise.resolve(null);
            }
            return res;
        };
        return wrapper;
    };
    // req.invalidateCache = (cacheId:string) => {
    //     delete req[_reqCacheKey][cacheId];
    // };
    next();
});
//# sourceMappingURL=instantiate-cache-interceptor.js.map