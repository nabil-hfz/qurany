import { Column, Entity } from 'typeorm';
import { AppBaseEntity } from './base.entity';

/**
 * Represents a user entity in the database.
 * Each user can have multiple roles.
 */
@Entity({ name: 'users' })
export class UserEntity extends AppBaseEntity {

  /**
   * The user's primary email address.
   */
  @Column({ nullable: true })
  email?: string;

  /**
   * Whether the user's email address has been verified.
   */
  @Column({ default: false })
  emailVerified!: boolean;

  /**
   * The user's display name.
   */
  @Column({ nullable: true })
  displayName?: string;

  /**
   * The URL of the user's profile picture.
   */
  @Column({ nullable: true })
  photoURL?: string;

  /**
   * The user's primary phone number.
   */
  @Column({ nullable: true })
  phoneNumber?: string;

  /**
   * Indicates whether the user is disabled. A disabled user cannot sign in.
   */
  @Column({ default: false })
  disabled!: boolean;

  /**
   * Custom claims set for the user, typically used for access control and permissions.
   */
  @Column('simple-json', { nullable: true })
  customClaims?: { [key: string]: any };

  /**
   * The time at which the user's tokens are valid after. Used to enforce token revocation.
   */
  @Column({ nullable: true })
  tokensValidAfterTime?: Date;
}
