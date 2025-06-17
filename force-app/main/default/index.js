const makeRequest = async (url, onSuccess) => {
    return new Promise((fulfill) => {
        fulfill('Yay, fulfilled activated')
    }, 3000)
}

const seller = await makeRequest('/api/seller/${sellerId}')
const firstProductId = seller.productIds[0] 

const product = await makeRequest('/api/product/${productId}')
const firstReviewId = product.reviewId[0]

const review = await makeRequest('/api/review/${reviewId}')
const authorName = review.author.name           