<template>
<div id="select-item-step">
  <v-layout>
    <v-flex md4>
      <v-text-field class="mb-0" :label="fromIng ? '素材名' : '作成アイテム'" v-model="query"></v-text-field>
    </v-flex>
    <v-flex md8>
      <div>
        <p class="text-xs-left mt-2 mb-0" v-if="loadingItems">
          を検索
          <v-progress-circular indeterminate class="primary--text">
          </v-progress-circular>
        </p>
        <p class="text-xs-left mt-4 mb-0" v-else>
          を検索
        </p>
      </div>
    </v-flex>
  </v-layout>

  <v-layout>
    <v-flex md12>
      <v-checkbox class="mt-0" label="材料から検索" v-model="fromIng">
      </v-checkbox>
    </v-flex>
  </v-layout>

  <v-layout class="mt-4">
    <v-flex md12>
      <h6>検索結果</h6>
      <v-data-table no-data-text="該当アイテムがありません" :items="items"
                    :headers="[{ text: 'アイテム名', value: 'アイテム名'}]"
                    rows-per-page-text="アイテム表示数"
                    hide-headers>
        <template slot="items" slot-scope="r">
          <th class="text-md-center">
            <item-button both :item="r.item">
            </item-button>
          </th>
          <td>
            <v-btn small @click.native="addTarget(r.item)">候補に追加</v-btn>
          </td>
        </template>
      </v-data-table>
    </v-flex>
  </v-layout>

  <v-layout class="mt-4">
    <v-flex md12>
      <h6>作成候補</h6>
      <v-data-table no-data-text="作成候補はありません" :items="targets"
                    :headers="[{ text: 'アイテム名', value: 'アイテム名'}]"
                    rows-per-page-text="アイテム表示数"
                    hide-headers
                    hide-actions>
        <template slot="items" slot-scope="r">
          <th class="text-md-center">
            <item-button both :item="r.item">
            </item-button>
          </th>
          <td>
            <v-btn small @click.native="removeTarget(r.item)">候補から削除</v-btn>
          </td>
        </template>
      </v-data-table>
      <v-divider></v-divider>
    </v-flex>
  </v-layout>
</div>
</template>

<script>
import ItemButton from '../ItemButton.vue'
import _ from 'lodash'
import { baseURL, getCall } from '../rest'

export default {
  name: 'select-item-step',
  props: ['targets'],
  data: () => ({
    query: '',
    fromIng: false,
    items: [],
    loadingItems: false,
  }),
  watch: {
    query: function() {
      if (this.query != '') {
        this.lazyGetItems()
      }
    },
    fromIng: function() {
      if (this.query != '') {
        this.getItems()
      }
    },
  },
  methods: {
    lazyGetItems: _.debounce(
      function() {
        this.getItems()
      },
      500
    ),
    getItems: function() {
      this.loadingItems = true
      getCall(baseURL+'/items?migemo=true&only-products=true&from-ingredients='+this.fromIng+'&query='+this.query, (xhr) => {
        if (xhr.readyState==4 && xhr.status==200) {
          this.items = JSON.parse(xhr.response)['アイテム一覧']
          this.loadingItems = false
        }
      })
    },
    addTarget: function(item) {
      this.$emit('addTarget', item)
    },
    removeTarget: function(item) {
      this.$emit('removeTarget', item)
    },
  },
  components: {
    ItemButton
  }
}
</script>

<style scope>
</style>