"""
Flask application factory
"""
from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from flask_login import LoginManager
import os
import threading

db = SQLAlchemy()
login_manager = LoginManager()
db_lock = threading.Lock()

def create_app():
    app = Flask(__name__)
    
    # Configuration
    app.config['SECRET_KEY'] = os.environ.get('SECRET_KEY', 'dev-secret-key-change-in-production')
    app.config['SQLALCHEMY_DATABASE_URI'] = os.environ.get('DATABASE_URL', 'sqlite:///ecommerce.db')
    app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
    app.config['SQLALCHEMY_ENGINE_OPTIONS'] = {
        'pool_pre_ping': True,
        'pool_recycle': 300,
        'connect_args': {'timeout': 20}
    }
    app.config['STRIPE_PUBLISHABLE_KEY'] = os.environ.get('STRIPE_PUBLISHABLE_KEY', '')
    app.config['STRIPE_SECRET_KEY'] = os.environ.get('STRIPE_SECRET_KEY', '')
    
    # Initialize extensions
    db.init_app(app)
    login_manager.init_app(app)
    login_manager.login_view = 'auth.login'
    login_manager.login_message_category = 'info'
    
    @login_manager.user_loader
    def load_user(user_id):
        from app.models import User
        return User.query.get(int(user_id))
    
    # Register blueprints
    from app.main import bp as main_bp
    app.register_blueprint(main_bp)
    
    from app.auth import bp as auth_bp
    app.register_blueprint(auth_bp, url_prefix='/auth')
    
    from app.admin import bp as admin_bp
    app.register_blueprint(admin_bp, url_prefix='/admin')
    
    from app.cart import bp as cart_bp
    app.register_blueprint(cart_bp, url_prefix='/cart')
    
    # Create database tables
    with app.app_context():
        init_database()
    
    return app

def init_database():
    """Initialize database with proper error handling and concurrency control"""
    with db_lock:
        try:
            # Import models to ensure they're registered
            from app.models import User, Category, Product, CartItem, Order, OrderItem
            
            # Create all tables
            db.create_all()
            
            # Check if we need to create sample data
            if Category.query.count() == 0:
                create_sample_data()
                
        except Exception as e:
            print(f"Database initialization error: {e}")
            # If there's an error, try to rollback and continue
            try:
                db.session.rollback()
            except:
                pass
def create_sample_data():
    """Create sample products and categories for demo purposes"""
    try:
        from app.models import Product, Category
        
        # Create categories
        electronics = Category(name='Electronics', description='Electronic devices and gadgets')
        clothing = Category(name='Clothing', description='Fashion and apparel')
        books = Category(name='Books', description='Books and literature')
        
        db.session.add_all([electronics, clothing, books])
        db.session.flush()  # Get IDs without committing
        
        # Create sample products
        products = [
            Product(
                name='Wireless Headphones',
                description='High-quality wireless headphones with noise cancellation',
                price=99.99,
                stock=50,
                category_id=electronics.id,
                image_url='https://images.pexels.com/photos/3394650/pexels-photo-3394650.jpeg?auto=compress&cs=tinysrgb&w=400'
            ),
            Product(
                name='Smartphone',
                description='Latest smartphone with advanced features',
                price=699.99,
                stock=30,
                category_id=electronics.id,
                image_url='https://images.pexels.com/photos/404280/pexels-photo-404280.jpeg?auto=compress&cs=tinysrgb&w=400'
            ),
            Product(
                name='Classic T-Shirt',
                description='Comfortable cotton t-shirt in various colors',
                price=19.99,
                stock=100,
                category_id=clothing.id,
                image_url='https://images.pexels.com/photos/8532616/pexels-photo-8532616.jpeg?auto=compress&cs=tinysrgb&w=400'
            ),
            Product(
                name='Programming Guide',
                description='Complete guide to modern programming practices',
                price=29.99,
                stock=75,
                category_id=books.id,
                image_url='https://images.pexels.com/photos/256417/pexels-photo-256417.jpeg?auto=compress&cs=tinysrgb&w=400'
            ),
            Product(
                name='Laptop',
                description='High-performance laptop for professionals',
                price=1299.99,
                stock=15,
                category_id=electronics.id,
                image_url='https://images.pexels.com/photos/205421/pexels-photo-205421.jpeg?auto=compress&cs=tinysrgb&w=400'
            ),
            Product(
                name='Designer Jacket',
                description='Stylish jacket for all seasons',
                price=89.99,
                stock=25,
                category_id=clothing.id,
                image_url='https://images.pexels.com/photos/1183266/pexels-photo-1183266.jpeg?auto=compress&cs=tinysrgb&w=400'
            )
        ]
        
        db.session.add_all(products)
        db.session.commit()
        print("Sample data created successfully!")
        
    except Exception as e:
        print(f"Error creating sample data: {e}")
        db.session.rollback()
    
    # Create categories
    electronics = Category(name='Electronics', description='Electronic devices and gadgets')
    clothing = Category(name='Clothing', description='Fashion and apparel')
    books = Category(name='Books', description='Books and literature')
    
    db.session.add_all([electronics, clothing, books])
    db.session.commit()
    
    # Create sample products
    products = [
        Product(
            name='Wireless Headphones',
            description='High-quality wireless headphones with noise cancellation',
            price=99.99,
            stock=50,
            category_id=electronics.id,
            image_url='https://images.pexels.com/photos/3394650/pexels-photo-3394650.jpeg?auto=compress&cs=tinysrgb&w=400'
        ),
        Product(
            name='Smartphone',
            description='Latest smartphone with advanced features',
            price=699.99,
            stock=30,
            category_id=electronics.id,
            image_url='https://images.pexels.com/photos/404280/pexels-photo-404280.jpeg?auto=compress&cs=tinysrgb&w=400'
        ),
        Product(
            name='Classic T-Shirt',
            description='Comfortable cotton t-shirt in various colors',
            price=19.99,
            stock=100,
            category_id=clothing.id,
            image_url='https://images.pexels.com/photos/8532616/pexels-photo-8532616.jpeg?auto=compress&cs=tinysrgb&w=400'
        ),
        Product(
            name='Programming Guide',
            description='Complete guide to modern programming practices',
            price=29.99,
            stock=75,
            category_id=books.id,
            image_url='https://images.pexels.com/photos/256417/pexels-photo-256417.jpeg?auto=compress&cs=tinysrgb&w=400'
        ),
        Product(
            name='Laptop',
            description='High-performance laptop for professionals',
            price=1299.99,
            stock=15,
            category_id=electronics.id,
            image_url='https://images.pexels.com/photos/205421/pexels-photo-205421.jpeg?auto=compress&cs=tinysrgb&w=400'
        ),
        Product(
            name='Designer Jacket',
            description='Stylish jacket for all seasons',
            price=89.99,
            stock=25,
            category_id=clothing.id,
            image_url='https://images.pexels.com/photos/1183266/pexels-photo-1183266.jpeg?auto=compress&cs=tinysrgb&w=400'
        )
    ]
    
    db.session.add_all(products)
    db.session.commit()