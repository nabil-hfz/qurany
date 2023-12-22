import { Component, Input, OnInit } from '@angular/core';

import { Track } from 'ngx-audio-player';
import { RecitationModel } from '../../models/recitation.model';


@Component({
  selector: 'kawtharuna-audio-player',
  templateUrl: './kawtharuna-audio-player.component.html',
  styleUrl: './kawtharuna-audio-player.component.css'
})
export class KawtharunaAudioPlayerComponent implements OnInit {

  mssapDisplayTitle = true;
  mssapDisablePositionSlider = true;
  mssapDisplayRepeatControls = true;
  mssapDisplayVolumeControls = true;
  mssapDisplayVolumeSlider = true;

  // Material Style Simple Audio Player
  mssapPlaylist: Track[] = [
    {
      title: 'Audio Title',
      link: 'https://storage.googleapis.com/kawtharuna-prod.appspot.com/audios/khatme/abu_bakr_al_shatri/1/02.mp3?GoogleAccessId=firebase-adminsdk-wrplf%40kawtharuna-prod.iam.gserviceaccount.com&Expires=16447017600&Signature=bkTIj%2FQklPY4y9vjWkqyXFOaIORE3ew0Y1wpmnQgLqHIrgFckQubLUJEX3jDb4ZlDP9du1dz2QDR0AHzmYndBnV9W2b64Mj6qzS%2F6voSYg9LIdts4imLfl8C3Q9WpN1VSyFmfgnJMMZtldPL5QPW60TTAvX3%2FWLomuS8CBDyG8xfbptxfEZPwpcf2a0%2BWHckfTUCyU212azK2Y6pShD4hDaqkUmhgV85jXWIsVcIRF0JunRLiywtLU6PjDscXf35FznyU6CUbB0WEZxDtsumpWuHHYNIsE4dnnIpfXR3giUhA5bh4htYLU5oNE%2BMZH3IWyHCDPLJtN6dKV%2F9Gb1hcQ%3D%3D',
      artist: 'Audio Artist',
      duration: 100,
    }
  ];

  constructor() {
    console.debug('recitations is ', this.recitations);

  }
  @Input('recitations')
  recitations: RecitationModel[] = [];

  ngOnInit(): void {
    console.debug('recitations is ', this.recitations);
    this.recitations.forEach(recitation => {
      const res = new Track();
      res.title = recitation.title.en ?? '';
      res.link = recitation.audio ?? '';
      res.artist = recitation.reciter.name.en;
      res.duration = recitation.duration;
      // {
      //   title: recitation.title.en ?? '',
      //   link: recitation.audio ?? '',
      //   artist: recitation.reciter.name.en,
      //   duration: recitation.duration,
      // }
      this.mssapPlaylist.push(res);
      console.debug(res)
    });
  }

  // onEnded(event: any) {

  // }
  // For Streaming Audio From URL 
  // set mediaType = 'stream' 
  // mssapPlaylist: Track[] = [
  //   {
  //     title: 'Audio Title',
  //     link: 'Link to Streaming URL',
  //     mediaType: 'stream'
  //   }
  // ];
}
