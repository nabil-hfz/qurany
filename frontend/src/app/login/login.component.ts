import { ActivatedRoute, Router } from '@angular/router';
import { Component } from '@angular/core';
import { MatDialogRef } from '@angular/material/dialog';
import { Observable, map, of } from 'rxjs';
import { AccountService } from '../services/account/account.service';

@Component({
  selector: 'app-login-dialog',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.scss']
})
export class LoginComponent {
  error: any;
  email: string = '';
  password: string = '';
  loading$ = of(false);
  values$: Observable<any> | undefined;

  constructor(
    public dialogRef: MatDialogRef<LoginComponent>,
    public accountService: AccountService,
    public route: ActivatedRoute,
    public router: Router,
  ) { }

  onLogin(): void {
    this.loading$ = of(true);

    this.values$ = this.accountService
      .login(this.email, this.password);

    this.values$.subscribe({
      next: (value) => {
        this.dialogRef.close();
        this.loading$ = of(false);
        this.error = null;
        // this.route
        this.router.navigate(['../'])
      },
      error: (error) => {
        this.error = error;
        console.error(error);
        this.loading$ = of(false);
      },
    });
  }

  onClose() {
    this.dialogRef.close();
  }
}

