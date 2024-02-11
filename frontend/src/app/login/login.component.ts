import { ActivatedRoute } from '@angular/router';
import { Component } from '@angular/core';
import { MatDialogRef } from '@angular/material/dialog';
import { of } from 'rxjs';
import { AccountService } from '../services/account/account.service';

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
    public accountService: AccountService,
    public dialogRef: MatDialogRef<LoginComponent>,

  ) { }

  onLogin(): void {
    this.isLoading = true;

    console.log(`Email: ${this.email}, Password: ${this.password}`);
    const successs = this.accountService.login(this.email, this.password);
    if (successs) {

    }
    this.dialogRef.close();
    this.isLoading = false;
    // setTimeout(() => {
    //   // Perform login logic here
    //   this.isLoading = false;
    // }, 2000);
  }
  onClose() {
    this.dialogRef.close();
  }
}

