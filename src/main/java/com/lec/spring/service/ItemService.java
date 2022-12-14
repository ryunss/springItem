package com.lec.spring.service;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Order;
import org.springframework.stereotype.Service;

import com.lec.spring.domain.Buy;
import com.lec.spring.domain.Cart;
import com.lec.spring.domain.Category;
import com.lec.spring.domain.Color;
import com.lec.spring.domain.Contentfile;
import com.lec.spring.domain.Item;
import com.lec.spring.domain.Review;
import com.lec.spring.domain.Size;
import com.lec.spring.domain.Tag;
import com.lec.spring.domain.User;
import com.lec.spring.domain.ajax.QryItemCount;
import com.lec.spring.domain.ajax.QryResult;
import com.lec.spring.domain.ajax.QryReviewList;
import com.lec.spring.domain.ajax.QryTotalPrice;
import com.lec.spring.repository.BuyRepository;
import com.lec.spring.repository.CartRepository;
import com.lec.spring.repository.CategoryRepository;
import com.lec.spring.repository.ColorRepository;
import com.lec.spring.repository.ContentfileRepository;
import com.lec.spring.repository.ItemRepository;
import com.lec.spring.repository.ReviewRepository;
import com.lec.spring.repository.SizeRepository;
import com.lec.spring.repository.TagRepository;
import com.lec.spring.repository.UserRepository;
import com.lec.spring.util.U;

@Service
public class ItemService {
	
	@Autowired
	private ItemRepository itemRepository;
	@Autowired
	private CategoryRepository categoryRepository;
	@Autowired
	private TagRepository tagRepository;
	@Autowired
	private ContentfileRepository contentfileRepository;
	@Autowired
	private SizeRepository sizeRepository;
	@Autowired
	private ColorRepository colorRepository;
	@Autowired
	private CartRepository cartRepository;
	@Autowired
	private BuyRepository buyRepository;
	@Autowired
	private ReviewRepository reviewRepository;
	@Autowired
	private UserRepository userRepository;
	
	@Transactional
	public List<Category> categoryList() {
		return categoryRepository.findAll();
	}
	
	@Transactional
	public List<Tag> tagList() {
		return tagRepository.findAll();
	}
	
	@Transactional
	public List<Item> itemList() {
		return itemRepository.findTop20ByIsvalidOrderByIdDesc(true);
	}
	
	@Transactional
	public Item findByisvalidItem(Long id){
		return itemRepository.findByIsvalidAndId(true, id);
	}
	
	@Transactional
	public Item findByItemid(Long id) {
		return itemRepository.findById(id).get();
	}
	
	@Transactional
	public List<Contentfile> getItemContentfile(Item id) {
		return contentfileRepository.findByItem(id);
	}
	
	@Transactional
	public List<Size> getItemSize(Item id) {
		return sizeRepository.findByItem(id);
	}
	
	@Transactional
	public List<Color> getItemColor(Item id) {
		return colorRepository.findByItem(id);
	}
	
	@Transactional
	public void registerCart(Long color_id, Long size_id, Long count, Item id) {
		User user = U.getLoggedUser();
		Cart cart = new Cart();
		
		cart.setItem(id);
		cart.setUser(user);
		cart.setColor(colorRepository.findById(color_id).orElse(null));
		cart.setSize(sizeRepository.findById(size_id).orElse(null));
		cart.setCount(count);
		cartRepository.saveAndFlush(cart);
	}
	
	public List<Cart> cartList(){
		User user = U.getLoggedUser();
		
		return cartRepository.findByUser(user);
	}

	public void changeOption(Long id, Long color, Long size) {
		Cart cart = cartRepository.findById(id).orElse(null);
		cart.setColor(colorRepository.findById(color).orElse(null));
		cart.setSize(sizeRepository.findById(size).orElse(null));
		cartRepository.saveAndFlush(cart);
	}

	public void deleteCart(Long id) {
		Cart c = cartRepository.findById(id).orElse(null);
		cartRepository.delete(c);
	}

	public QryItemCount setCountDB(Long id, Long cnt) {
		QryItemCount list = new QryItemCount();
		Cart cart = cartRepository.findById(id).orElse(null);
		cart.setCount(cnt);
		cartRepository.saveAndFlush(cart);
		list.setCount(1);
		list.setData(cnt);
		list.setStatus("OK");
		return list;
	}

	public QryTotalPrice getTotalPrice() {
		QryTotalPrice list = new QryTotalPrice();
		List<Cart> carts = cartRepository.findByUser(U.getLoggedUser());
		Long sum = 0L;
		for(Cart c : carts) {
			sum += c.getCount() * c.getItem().getDiscountPrice();
		}
		list.setCount(1);
		list.setData(sum);
		list.setStatus("OK");
		return list;
	}

	public Category getCategoryById(Long id) {
		Category c = categoryRepository.findById(id).get();
		return c;
	}

	public Tag getTagById(Long id) {
		Tag t = tagRepository.findById(id).get();
		return t;
	}
	
	public int getCartPayment() {
		User user = U.getLoggedUser();
		List<Cart> list = cartRepository.findByUser(user);
		for(Cart cart : list) {
			Buy buy = new Buy();
			buy.setColor(cart.getColor());
			buy.setCount(cart.getCount());
			buy.setItem(cart.getItem());
			buy.setSize(cart.getSize());
			buy.setUser(user);
			buyRepository.saveAndFlush(buy);
			
			Item item = cart.getItem();
			item.setStock(item.getStock() - cart.getCount());
			item.setSell(item.getSell() + cart.getCount());
			itemRepository.saveAndFlush(item);
		}
		return 1;
	}

	public void deleteCartAll() {
		cartRepository.deleteAll();	
	}

	public int directCart(Long id, Long color, Long size, Long count) {
		User user = U.getLoggedUser();
		Item i = itemRepository.findById(id).orElse(null);
		Color c = colorRepository.findById(color).orElse(null);
		Size s = sizeRepository.findById(size).orElse(null);
		
		Buy buy = new Buy();
		buy.setUser(user);
		buy.setItem(i);
		buy.setColor(c);
		buy.setSize(s);
		buy.setCount(count);
		buyRepository.saveAndFlush(buy);
		
		i.setStock(i.getStock() - count);
		i.setSell(i.getSell() + count);
		itemRepository.saveAndFlush(i);
		
		return 1;
	}

	public List<Buy> getBuyList() {
		User user = U.getLoggedUser();
		return buyRepository.findByUserOrderByIdDesc(user);
	}

	public Category latestList(Long category) {
		Category c = null;
		return c;
	}
	public Category likeList(Long category) {
		Category c = null;
		return c;
	}
	public Category salesList(Long category) {
		Category c = null;
		return c;
	}
	public Category lowpriceList(Long category) {
		Category c = null;
		return c;
	}
	
	
	// review *****************************************
	public QryResult registerReview(Long itemId, Long user_id, String content, Long star) {
		Item i = itemRepository.findById(itemId).orElse(null);
		User u = userRepository.findById(user_id).orElse(null);
		Review r = new Review();
		r.setContent(content);
		r.setItem(i);
		r.setStar((double)star);
		r.setUser(u);
		reviewRepository.saveAndFlush(r);
		
		List<Review> rList = reviewRepository.findByItem(i);
		int cnt = rList.size();
		Double sum = 0D;
		for(Review re : rList) sum += re.getStar();
		if (cnt != 0) i.setAvgstar(sum / cnt);
		itemRepository.save(i);
		
		QryResult list = new QryResult();
		list.setCount(1);
		list.setStatus("OK");
		return list;
	}
	public QryReviewList reviewList(Long id) {
		QryReviewList list = new QryReviewList();
		List<Review> review = null;
		Item itemId = itemRepository.findById(id).orElse(null);
		review = reviewRepository.findByItem(itemId, Sort.by(Order.desc("regDate")));
		list.setCount(review.size());
		list.setList(review);
		list.setStatus("OK");
		return list;
	}
	public QryResult deleteComment(Long id) {
		Review review = reviewRepository.findById(id).orElse(null);
		
		int count = 0 ;
		String status = "FAIL";
		
		if(review != null) {
			reviewRepository.delete(review);
			count = 1;
			status = "OK";
		}
		
		QryResult result = QryResult.builder()
				.count(count)
				.status(status)
				.build()
				;
		
		return result;
	}
	// ***************************************************
}
