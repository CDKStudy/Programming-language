structure HashedDictionary = DictionaryFn(struct
	type ''k hash_function = ''k -> int

	
	(* TODO: replace unit with the type you decide upon *)
  type (''k, 'v) dictionary = {
    bucket_count: int,
    hash_function: ''k -> int,
    buckets: (''k * 'v) list array
  }
	

    type ''k create_parameter_type = (int * (''k hash_function))

    fun create(bucket_count_request : int, hash : ''k hash_function) : (''k,'v) dictionary = 
    {
      bucket_count = bucket_count_request,
      hash_function = hash,
      buckets = Array.array(bucket_count_request, [])
    }

	fun positive_remainder(v : int, n : int) : int = 
		let
			val result = v mod n 
		in 
			if result >= 0 then result else result+n
		end 


    fun get(dict : (''k,'v) dictionary, key : ''k) : 'v option = 
    let
        val bucket_index = 
            let
                val hash = #hash_function dict key
                val bucket_count = #bucket_count dict
            in
                positive_remainder(hash, bucket_count)
            end
        val bucket = Array.sub(#buckets dict, bucket_index)
    in
        Chain.get(bucket, key)
    end

    fun put(dict : (''k,'v) dictionary, key : ''k , value : 'v) : (''k,'v) dictionary * 'v option =
    let
        val hash_function = #hash_function dict
        val bucket_count = #bucket_count dict

        val bucket_index = positive_remainder(hash_function key, bucket_count)
        val bucket = Array.sub(#buckets dict, bucket_index)

        val (updated_bucket, old_value) = Chain.put(bucket, key, value)

        val new_buckets = Array.array(bucket_count, [])
        val _ = Array.copy{src = #buckets dict, dst = new_buckets, di = 0}
        val _ = Array.update(new_buckets, bucket_index, updated_bucket)
    in
        ({bucket_count = bucket_count, hash_function = hash_function, buckets = new_buckets}, old_value)
    end

    fun remove(dict : (''k,'v) dictionary, key : ''k) : (''k,'v) dictionary * 'v option =
    let
        val hash_function = #hash_function dict
        val bucket_count = #bucket_count dict

        val bucket_index = positive_remainder(hash_function key, bucket_count)
        val chain = Array.sub(#buckets dict, bucket_index)

        val (new_chain, old_value) = Chain.remove(chain, key)

        val new_buckets = Array.array(bucket_count, [])
        val _ = Array.copy{src = #buckets dict, dst = new_buckets, di = 0}
        val _ = Array.update(new_buckets, bucket_index, new_chain)
    in
        ({bucket_count = bucket_count, hash_function = hash_function, buckets = new_buckets}, old_value)
    end


	fun entries(dict : (''k,'v) dictionary) : (''k*'v) list = 
    let
        val bucket_count = #bucket_count dict
        val hash_function = #hash_function dict
        val buckets = #buckets dict
        fun collectBucket(bucket_index, acc) =
            if bucket_index < bucket_count 
            then
                let
                    val chain = Array.sub(buckets, bucket_index)
                in
                    collectBucket(bucket_index + 1, chain @ acc)
                end
            else
                acc
    in
        collectBucket(0, [])
    end

end)