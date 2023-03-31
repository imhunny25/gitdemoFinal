import { LightningElement } from 'lwc';
import {loadScript, loadStyle} from 'lightning/platformResourceLoader';
import FLICK from '@salesforce/resourceUrl/flickity';

export default class ImageSilderGallary extends LightningElement {
    connectedCallback() {
        Promise.all([
            loadScript(this, FLICK + '/jquery.min.js'),
            //loadScript(this, FLICK + '/flickity.pkgd.min.js')
        ]).then(() => {
            Promise.all([
                    loadStyle(this, FLICK + '/flickity.css')
                ]).then(() => {
                    $(this.template.querySelector('div[class="carousel"]')).flickity({
                        autoPlay: 1000
                    });
                })
                .catch(e => {
                    console.log('Error:' + e);
                });
        }).catch(e => {
            console.log('Error:' + e);
        });
    }
}