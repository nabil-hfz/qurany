import { ActivatedRoute } from '@angular/router';
import { Component } from '@angular/core';
import { MatDialogRef } from '@angular/material/dialog';
import { Observable, map, of } from 'rxjs';
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
  loading$ = of(false);
  isDisabled$ = of(false);
  values$: Observable<any> | undefined;

  constructor(
    public dialogRef: MatDialogRef<LoginComponent>,
    public accountService: AccountService,
  ) { }

  onLogin(): void {
    this.loading$ = of(true);

    this.values$ = this.accountService
      .login(this.email, this.password);

    this.values$.subscribe(response => {
      this.dialogRef.close();
      return response;
    });

  }

  onClose() {
    this.dialogRef.close();
  }
}

