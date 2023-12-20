import { Operation } from "just-diff";

export type uuid = string;
export type DocumentData = { [field: string]: any };
export declare type DiffResult = Array<{
  op: Operation;
  path: Array<string | number>;
  value: any;
}>;

export declare type Nullable<T> = T | undefined | null;
