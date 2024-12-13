import * as h from '../mumu/mumu.mjs'

function sizeof(object) {
	const objectList = [];
	const stack = [object];
	let bytes = 0;

	while (stack.length) {
		const value = stack.pop();

		switch (typeof value) {
			case 'boolean':
				bytes += 4;
				break;
			case 'string':
				bytes += value.length * 2;
				break;
			case 'number':
				bytes += 8;
				break;
			case 'bigint':
				bytes += 16;
				break;
			case 'function':
				bytes += 16;
				break;
			case 'symbol':
				bytes += value.description.length * 2;
				break;
			case 'object':
				if (!objectList.includes(value)) {
					objectList.push(value);
					for (const prop in value) {
						stack.push(prop);
						if (value.hasOwnProperty(prop)) {
							stack.push(value[prop]);
						}
					}
				}
				break;
		}
	}

	return bytes;
}

let cache = {}

export function get_cache() {
	return cache
}

export function reset_cache() {
	cache = {}
}

export function cache_size() {
	return sizeof(cache)
}

export function cache_count() {
	return Object.keys(cache).length
}

export function memoize(fn, args, cb) {
	const key = h.hash(fn.toString()).toString() + h.hash(args.toString()).toString()
	return key in cache ? cache[key] : cache[key] = cb()
}
