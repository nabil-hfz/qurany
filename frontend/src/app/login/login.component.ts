import { ActivatedRoute } from '@angular/router';
import { Component } from '@angular/core';
import { MatDialogRef } from '@angular/material/dialog';
import { map, of } from 'rxjs';
import { AccountService } from '../services/account/account.service';
// import { AccountService } from '../services/account/account.service';

@Component({
  selector: 'app-login-dialog',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.scss']
})
export class LoginComponent {
  email: string = '';
  password: string = '';
  isLoading: boolean = false;
  isDisabled$ = of(false);

  constructor(
    public dialogRef: MatDialogRef<LoginComponent>,
    public accountService: AccountService,

  ) { }

  onLogin(): void {
    this.isLoading = true;

    this.accountService
      .login(this.email, this.password)
      // .pipe((successs) => {
      //   console.log(successs);
      //   if (successs) {
      //   }
      //   this.dialogRef.close();
      //   this.isLoading = false;
      //   return successs;
      // });


  }
  onClose() {
    this.dialogRef.close();
  }
}

