import resolve from '@rollup/plugin-node-resolve'
import commonjs from '@rollup/plugin-commonjs'
import babel from '@rollup/plugin-babel'
import { terser } from 'rollup-plugin-terser'

const terserOptions = {
  safari10: true
}

export default {
  input: 'src/index.js',
  output: {
    file: 'dist/refactored_invention.min.js',
    format: 'umd',
    name: 'StimulusReflex'
  },
  plugins: [resolve(), commonjs(), babel(), terser(terserOptions)]
}
