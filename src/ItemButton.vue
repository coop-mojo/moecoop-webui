<template>
  <div id="item-button">
    <v-btn flat small :color="link" class="small hidden-xs-only" @click.native="updateItem(item)">
      {{item.アイテム名}}
    </v-btn>
    <v-btn flat small :color="link" class="small hidden-sm-and-up" @click.native="showItemDetailTab(item)">
      {{item.アイテム名}}
    </v-btn>
  </div>
</template>

<script>
export default {
  name: 'item-button',
  props: {
    item: Object,
    both: {
      type: Boolean,
      default: false,
    },
  },
  data: () => ({
    dialog: false,
  }),
  computed: {
    classes() {
      return {
        'both': this.both,
      }
    },
    link() {
      return this.$store.state.linkColor
    },
  },
  methods: {
    updateItem: function(it) {
      this.$store.dispatch('setItem', it).then(() => {
        const rs = this.$store.state.item.レシピ
        if (this.both && rs.length > 0) {
          this.$store.dispatch('setRecipe', { recipe: rs[0], num: 1 })
        }
      })
    },
    showItemDetailTab: function(it) {
      this.updateItem(it)
      this.$store.commit('gotoTab', 'item-detail-tab')
    },
  }
}
</script>

<style scoped>
  .small {
    margin: 0px;
    padding: 0 0px;
  }
</style>
