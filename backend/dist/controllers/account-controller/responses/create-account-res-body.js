"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.CreateAccountResBody = void 0;
class CreateAccountResBody {
    constructor(user) {
        this.tutorial = "Success!!! Next steps: In your client side (Flutter or JavaScript), you should 'signInWithEmailAndPassword'. After, set the header 'Authorization' with the result of the 'getIdToken' function that is on the Firebase Authentication package for client side";
        this.uid = user.uid;
        this.status = "USER_CREATED_SUCCESSFULLY";
    }
}
exports.CreateAccountResBody = CreateAccountResBody;
//# sourceMappingURL=create-account-res-body.js.map