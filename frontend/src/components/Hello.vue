<template>
    <h1>{{data}}</h1>
</template>

<script>
    import axios from 'axios';
    export default {
        name: "Hello",
        data() {
            return {
                data: null
            }
        },
        created: function () {
            axios.get('http://localhost:8080/hello').then(res => {
                this.data = res.data;
            }).catch(() => console.log("erreur"));
        }
    }
</script>

<style scoped>

</style>