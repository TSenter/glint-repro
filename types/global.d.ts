import '@glint/environment-ember-loose';
import '@glint/environment-ember-template-imports';

import PageTitleRegistry from 'ember-page-title/template-registry';

declare module '@glint/environment-ember-loose/registry' {
  export default interface Registry extends PageTitleRegistry {}
}
