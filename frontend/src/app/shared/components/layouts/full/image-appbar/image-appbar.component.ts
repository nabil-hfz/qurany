import { Component, EventEmitter, Input, OnInit, Output } from "@angular/core";
import { Observable } from "rxjs";
import { finalize, map, takeUntil } from "rxjs/operators";
import { ClearSubscriptionsComponent } from "src/app/shared/components/clear-subscriptions/clear-subscriptions.component";
import { UploadHelperService } from "src/app/shared/services/upload-helper.service";

@Component({
  selector: 'app-image-appbar',
  templateUrl: './image-appbar.component.html',
  styleUrls: ['./image-appbar.component.scss']
})
export class ImageAppbarComponent 
  extends ClearSubscriptionsComponent
  implements OnInit {
  loadingMedia!: boolean;
  imageUrl!: string;
  private _imageId!: string;
  errorMsg?: string;
  defaultMedia = "assets/images/users/thumb-2.png";

  get imageId() {
    return this._imageId
  }
  @Input() set imageId(data: any) {
    if(!data)return ;
    this._imageId = data;
    this.getImage()
  }

  @Output() newImage = new EventEmitter<any>();

  constructor(private upload: UploadHelperService) {
    super();
  }

  ngOnInit(): void {
  }

  getImage() {
    this.upload.getFileData(this._imageId).pipe(map(res => res.url!))
      .pipe(takeUntil(this.destroy$))
      .subscribe(res => {
        this.imageUrl = res;
      })
  }
}

