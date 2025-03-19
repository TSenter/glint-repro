import { hash } from '@ember/helper';
import { LinkTo } from '@ember/routing';

import type { TOC } from '@ember/component/template-only';
import type { ComponentLike } from '@glint/template';

function classes(...args: unknown[]): string {
  const classes = args.filter(Boolean);

  return classes.join(' ');
}

interface ItemSignature {
  Element: HTMLAnchorElement | HTMLDivElement;
  Args: (
    | {
        route: string;
        url?: never;
      }
    | {
        route?: never;
        url: string;
      }
  ) & {
    active?: boolean;
    disabled?: boolean;
  };
  Blocks: {
    default: [];
    group: [
      {
        Group: ComponentLike<GroupSignature>;
      },
    ];
  };
}

const Item: TOC<ItemSignature> = <template>
  {{#if @route}}
    <LinkTo
      class="list-group-item list-group-item-action"
      @route={{@route}}
      ...attributes
    >
      {{yield}}
    </LinkTo>
  {{else if @url}}
    <a
      class={{classes
        "list-group-item list-group-item-action"
        (if @active "active")
        (if @disabled "disabled")
      }}
      href={{@url}}
      ...attributes
    >
      {{yield}}
    </a>
  {{else}}
    <div class="list-group-item list-group-item-action" ...attributes>
      {{yield}}
    </div>
  {{/if}}
  {{#if (has-block "group")}}
    {{yield (hash Group=(component Group)) to="group"}}
  {{/if}}
</template>;

interface GroupSignature {
  Element: HTMLAnchorElement;
  Args: {
    route?: string;
  };
  Blocks: {
    header: [];
    group: [ComponentLike<ItemSignature>];
  };
}

const Group: TOC<GroupSignature> = <template>
  <div class="item">
    {{#if (has-block "header")}}
      {{#if @route}}
        <LinkTo
          class="header list-group-item list-group-item-action"
          @route={{@route}}
          ...attributes
        >
          {{yield to="header"}}
        </LinkTo>
      {{else}}
        <div class="header">
          {{yield to="header"}}
        </div>
      {{/if}}
    {{/if}}
    {{#if (has-block "group")}}
      {{yield (component Item) to="group"}}
    {{/if}}
  </div>
</template>;

export interface SidebarSignature {
  Element: HTMLDivElement;
  Args: {
    sticky?: boolean;
  };
  Blocks: {
    default: [
      {
        Group: ComponentLike<GroupSignature>;
        Item: ComponentLike<ItemSignature>;
      },
    ];
  };
}

const Sidebar: TOC<SidebarSignature> = <template>
  <div class="sidebar card" ...attributes>
    <div class="list-group d-flex flex-column overflow-auto">
      {{yield (hash Group=(component Group) Item=(component Item))}}
    </div>
  </div>
</template>;

<template>
  <Sidebar as |Menu|>
    <Menu.Group>
      <:header>
        Components
      </:header>
      <:group as |Item|>
        <Item @route="components.button">Button</Item>
        <Item @route="components.card">Card</Item>
        <Item @route="components.dropdown">Dropdown</Item>
        <Item @route="components.footer">Footer</Item>
        <Item @route="components.header">Header</Item>
        <Item @route="components.icon">Icon</Item>
        <Item @route="components.modal">Modal</Item>
        <Item @route="components.navbar">Navbar</Item>
        <Item @route="components.pagination">Pagination</Item>
        <Item @route="components.popover">Popover</Item>
        <Item @route="components.toaster">Toaster</Item>
        <Item @route="components.tooltip">Tooltip</Item>
        <Item @route="components.theme-switcher">Theme Switcher</Item>
      </:group>
    </Menu.Group>
    <Menu.Item @route="components.footer">Footer</Menu.Item>
    <Menu.Item @route="components.header">Header</Menu.Item>
    <Menu.Group @route="components.form">
      <:header>
        Forms
      </:header>
      <:group as |Item|>
        <Item @route="components.form.index">Form</Item>
        <Item @route="components.form.datetime">Datetime</Item>
        <Item @route="components.form.checkbox">Checkbox</Item>
        <Item @route="components.form.checkbox-group">Checkbox Group</Item>
        <Item @route="components.form.phone-input">Phone Input</Item>
        <Item @route="components.form.radio-group">Radio Group</Item>
        <Item @route="components.form.search">Search</Item>
        <Item @route="components.form.select">Select</Item>
        <Item @route="components.form.text-area">Text Area</Item>
        <Item @route="components.form.text-input">Text Input</Item>
      </:group>
    </Menu.Group>
  </Sidebar>
</template>
