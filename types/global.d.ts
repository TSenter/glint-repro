import '@glint/environment-ember-loose';
import '@glint/environment-ember-template-imports';

import PageTitleRegistry from 'ember-page-title/template-registry';

import Sample from './components/sample.gts';

declare module '@glint/environment-ember-loose/registry' {
  export default interface Registry extends PageTitleRegistry {
    Sample: typeof Sample;
  }
}
