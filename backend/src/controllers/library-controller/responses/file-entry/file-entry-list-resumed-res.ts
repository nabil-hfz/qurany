import { FileEntryResumedRes } from "./file-entry-resumed-res";

export class FileEntriesListResumedRes {
  constructor(public readonly data: FileEntryResumedRes[]) {}
}
